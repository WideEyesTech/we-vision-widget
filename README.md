WE Vision Widget - WideEyes We Vision JavaScript Widget
==============

A library to dinamically generate a widget that can be embedded in a website and connect to our [web services](http://docs.wide-eyes.it) to retrieve search results.

Table of Contents
=================
**Getting Started**

1. [Setup](#setup)
1. [Configuration](#configuration)
1. [Quick Start](#quick-start)
1. [Development process](#development-process)
1. [Contributing](#contributing)
1. [License](#license)

Setup
-------------
To setup your project, follow these steps:

Install and configure

#### Source Code

```sh
  git clone https://github.com/WideEyesTech/we-vision-widget
  npm install
```

Configuration
---------------

Before calling the script you need to append the configuration to the global object window.
See our [example](example.html) to see how you should do it.

#### Options

 * **apikey**: (string) The apikey that you obtain in [Wide Eyes dashboard](http://dashboard.wide-eyes.it/#/APIkey).
 * **numberOfElements**: The maximum number of elements that can appear in the Widget.
 * **widgetPositionAfter**: The CSS Selector of the element after which will be placed the widget.
 * **layout**: The layout of the widget.
  * **columnCount**: The number of columns of the widget.
   * **options**: Legal options for the number of columns in the widget.
   * **value**: The actual number of columns that the widget is configured to have.
  * **mobileColumnCount**: The number of columns of the widget when in mobile.
   * **options**: Legal options for the number of columns in mobile.
   * **value**:The actual number of columns that the widget is configured to have in mobile.
  * **itemCount**: The number of elements in the widget. 
   * **options**: Legal options for the number of elements in the widget.
   * **value**: The actual configuration of the number of elements in the widget.
 * **tile**: The configuration for each of the elements in the widget.
  * **hasImage**: The element should have an Image?.
  * **hasTitle**: The element should have a Title?.
  * **hasSubtitle**: The element should have a Subtitle?.
  * **hasDescription**: The element should have a Description?.
 * **mode**: The mode of execution of the widget (debug|production).
 
Also you will need to adjust the html templates and the CSS to meet your requirements, we only provide some generics as a foundation.

#### HTML

The HTML is created with handlebars templates that live in the templates folder. For instance you can modify the HTML of each of the products modifying ProductContainer.js
or modify the widget title in WidgetContainer.js.

#### CSS

Our styles are rendered from a handlebars template that live in templates folder (templates/style.hbs).
Take a look to this file, you will see how we reset the styles to apply to our widget.
You can modify this file as you will to make your widget get the look that you want.


Quick Start
-------------

```html
  <script>
    // Configure the product_id and the rest of the parameters.
    window.wide_eyes_product_id = document.getElementById("product-id").innerHTML;
    window.wide_eyes_config = {"apikey":"your_api_key",
                              "numberOfElements": 4,
                              "widgetPositionAfter":"#widget",
                              "layout": {
                                "columnCount": {
                                  "options": [1, 2, 4, 8],
                                  "value": 4
                                },
                                "mobileColumnCount": {
                                  "options": [1, 2],
                                  "value": 1
                                },
                                "itemCount": {
                                  "options": [4, 8, 16, 24],
                                  "value": 4
                                }
                              },
                              "tile": {
                                "hasImage": true,
                                "hasTitle": true,
                                "hasSubtitle": false,
                                "hasDescription": true
                              },
                              "mode": "debug" // default is production
                            };
    console.log(window.we_id_product);
  </script>
  <script src="the_url_of_your_main.js"></script>
```


Development process
--------------------

1. Install dependencies: ```npm install```
2. Run watcher & server: ```npm run dev```
3. Build for production: ```npm run build``` (generates build/main.js)


Contributing
-----------------

Want to contribute? Check out the [contributing guide](CONTRIBUTING.md)!

License
----------------

Copyright 2015 Wide Eyes Technologies S.L. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
