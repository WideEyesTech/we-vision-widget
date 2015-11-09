if typeof iFrameResize is 'undefined' then require '../js/vendor/iframe-resizer/src/iframeResizer'


class WeVisionWidget
	API_URL = 'http://api.wide-eyes.it'
	config = window.we_vision_config
	lastIdSearch = null
	iframe: null

	constructor: () ->
		# get script source
		script = document.getElementById 'we-vision-script'
		scriptSrc = script.getAttribute 'src'
		scriptSrc = scriptSrc.substring 0, scriptSrc.lastIndexOf('/')
		product_id = @getProductId()

		data =
			ProductId: product_id

		@getProducts product_id, (err, response) ->
			if err
				return
			@iframe = document.createElement 'iframe'
			@iframe.setAttribute 'width', '100%'
			@iframe.setAttribute 'id', 'we-vision-iframe'
			@iframe.setAttribute 'seamless', true
			@iframe.setAttribute 'frameborder', 'no'
			@iframe.setAttribute 'scrolling', 'no'

			widget = document.querySelector config.widgetContainer
			widget.appendChild @iframe

			iFrameResize({checkOrigin: false}, @iframe)

			if config.mode == 'debug'
				# have to be stringified so to pass it to the html string
				response = JSON.stringify response
				config = JSON.stringify(config)
				html =
					'<!DOCTYPE html>
					<html>
						<head>
						    <script>
									var config = '+config+';
						    	var products = '+response+';
									var product_id = "'+product_id+'";
						    </script>
							<base target="_blank"/>
						</head>
						<body>
							<section id="widget"></section>
							<section id="preview" class="magnifier-preview" style="width: 200px; height: 184px;"></section>
							<script src="'+scriptSrc+'/vendor/requirejs/require.js"></script>
							<script src="'+scriptSrc+'/vendor/iframe-resizer/src/iframeResizer.contentWindow.js"></script>
							<script src="'+scriptSrc+'/we_vision_internal.js"></script>
						</body>
					</html>'
			else if config.mode == 'production' or !config.mode
				response = JSON.stringify response
				config = JSON.stringify(config)
				# we_vision_internal_src = '/build/we_vision_internal.min.js'
				we_vision_internal_src = 'https://d7ljuhq7463v2.cloudfront.net/client-files/183/current/we_vision_internal.min.js'
				html =
					'<!DOCTYPE html>
					<html>
						<head>
						    <script>
									var config = '+config+';
							    var products = '+response+';
									var product_id = "'+product_id+'";
						    </script>
							<base target="_blank"/>
						</head>
						<body>
							<section id="widget"></section>
							<section id="preview" class="magnifier-preview" style="width: 200px; height: 184px;"></section>
							<script src="' + we_vision_internal_src + '"></script>
						</body>
					</html>'

			# copy html to iframe
			@iframe.contentWindow.document.open()
			@iframe.contentWindow.document.write html
			@iframe.contentWindow.document.close()

	postMessage: (msg) ->
		@iframe.contentWindow.postMessage(msg, "*");

	getProductId:  () ->
		idCont = document.querySelector config.productIdContainer
		id = idCont.innerHTML

	getProducts:  (id, callback) ->
		if id isnt @lastIdSearch
			@lastIdSearch = id
			if typeof config isnt 'object'
				config = JSON.parse(config)

			data =
				ProductId: id

			req = new XMLHttpRequest()
			req.addEventListener 'readystatechange', ->
				if req.readyState is 4 and req.status is 200
					response = JSON.parse(req.responseText)
					if response.result_both.length > 1
						response.result_both.splice 0, 1
						if config.maxNumProducts
							response.result_both.splice config.maxNumProducts
						callback null, response
					else
						callback {message: "No products found"}
				else if req.readyState is 4 and req.status isnt 200
					callback req.status

			req.open 'POST', API_URL + '/v1/SearchById', true
			req.setRequestHeader 'apikey', config.apikey
			req.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
			req.send JSON.stringify data
		else
			null

weVisionWidget = new WeVisionWidget
