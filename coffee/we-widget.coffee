class WeVisionWidget
	API_URL: 'http://api.wide-eyes.it'
	constructor: () ->

		# get script source
		script = document.getElementById 'we-vision-script'
		scriptSrc = script.getAttribute 'src'
		scriptSrc = scriptSrc.substring 0, scriptSrc.lastIndexOf('/')

		product_id = window.we_vision_product_id
		config = window.we_vision_config
		data =
			ProductId: product_id
			# MinNumResults: config.layout.numberOfElements + 1 || 5


		req = new XMLHttpRequest()
		req.addEventListener 'readystatechange', ->
			if req.readyState is 4 and req.status == 200

				# delete first product from results (it's the same than product_id)
				response = JSON.parse(req.responseText)
				response.result_both.splice 0, 1

				iframe = document.createElement 'iframe'
				iframe.setAttribute 'width', '100%'
				# iframe.setAttribute 'height', '500px'
				iframe.setAttribute 'id', 'we-vision-iframe'
				iframe.setAttribute 'seamless', true
				iframe.setAttribute 'frameborder', 'no'
				iframe.setAttribute 'scrolling', 'no'
				iframe.setAttribute 'onload', 'iFrameResize({checkOrigin: false}, "#we-vision-iframe")'

				widget = document.querySelector config.widgetContainer
				widget.appendChild iframe

				if config.mode == 'debug'
					# have to be stringified so to pass them to the html string
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
								<link rel="stylesheet" href="css/main.css">
								<base target="_blank"/>
							</head>
							<body>
								<section id="widget"></section>
								<section id="preview" class="magnifier-preview" style="width: 200px; height: 184px;"></section>
								<script src="'+scriptSrc+'/vendor/requirejs/require.js"></script>
								<script src="'+scriptSrc+'/vendor/iframe-resizer/src/iframeResizer.contentWindow.js"></script>
								<script src="'+scriptSrc+'/main.js"></script>
							</body>
						</html>'
				else if config.mode == 'production' or !config.mode
					response = JSON.stringify response
					config = JSON.stringify(config)
					css_src = scriptSrc+'/we_vision.min.css'
					we_vision_internal_src = scriptSrc + '/we_vision_internal.min.js'
					if (scriptSrc == '')
						we_vision_internal_src = 'we_vision_internal.min.js'
						css_src = 'we_vision.min.css'
					html =
						'<!DOCTYPE html>
						<html>
							<head>
							    <script>
										var config = '+config+';
								    var products = '+response+';
										var product_id = "'+product_id+'";
							    </script>
								<link rel="stylesheet" href="'+css_src+'">
								<base target="_blank"/>
							</head>
							<body>
								<section id="widget"></section>
								<section id="preview" class="magnifier-preview" style="width: 200px; height: 184px;"></section>
								<script src="'+we_vision_internal_src+'"></script>
							</body>
						</html>'

				# copy html to iframe
				iframe.contentWindow.document.open()
				iframe.contentWindow.document.write html
				iframe.contentWindow.document.close()

		req.open 'POST', @API_URL + '/v1/SearchById', true
		req.setRequestHeader 'apikey', config.apikey
		req.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
		req.send JSON.stringify data

weVisionWidget = new WeVisionWidget
