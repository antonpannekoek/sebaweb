SeBaWeb is a webpage to run [SeBa](https://github.com/amusecode/SeBa/) in a web browser.
It uses a WebAssembly version of SeBa for this.

## Installation

There is no need to build anything: the files in this project can all be copied into a directory that can be found and served by a webserver.

The webserver should recognize and be able to serve WebAssembly (`.wasm`) files, which is fine for modern webservers.

### Files

The really necessary files for SeBaWeb to function as a webpage are

- index.html
- base.css
- base.js
- seba.js
- seba.wasm
- banner.jpg
- favicon.ico
- en.json
- nl.json

The `seba.js` and `seba.wasm` form the WebAssembly code. `base.js` takes care of interfacing between the webpage and the WebAssembly, including handling all the sliders, inputs and other interactive elements on the page.

The `*.json` files are translation files.


## Development

If you want to extend the functionality of SeBaWeb, or simply want to update some texts or styling, here are some suggestions:

- Stick to `index.html`, `base.css` and `base.js` (and possibly images). `seba.js` should not be altered, otherwise you may lose functionality running the actual SeBa WebAssembly binary.

- Do not hard code any text in the `index.html` or `base.js` files. You can have dummy text, but use a key-phrase with a `data-i8n` attribute in the HTML file (see examples therein). When setting text in `base.js`, use the `_t` (translate) function with an appropriate key-phrase.

- All translations from key-phrases to supported languages are provided in the various `*.json` files. These are straightforward as far as content and format concerns; update these files if you have new text(s) to add.

- format the HTML, CSS, `base.js` and JSON files afterwards. See `format.sh` for details of the chosen indentation and formatter; you can simply run `sh format.sh` to ensure all files are formatted.


### Building the WebAssembly files

Note: you do *not* need to build the WebAssembly files: the `seba.wasm` is already a fully functional binary WebAssembly file.

If, however, there has been a change in the SeBa code itself that is also essential for the web version, you may want to recompile `seba.wasm`.

For building `seba.wasm`, make sure you have Emscripten installed: it is probably available through a package manager.
Emscripten entails a suite of compilers: a C and C++ compiler, a linker and some other tools. The executable you'll need are `emcc`, `em++`, `emar` and `emranlib`, but you probably want the full suite properly installed, since these executables may have dependencies on other Emscripten tools.

Once installed, you can use the `build.sh` script in this directory: it requires the root directory of the SeBa source code as its first argument, and will then 1/ clean the SeBa source code, 2/ build all code using Emscripten compilers, and 3/ copy the resulting files (`seba.wasm` and `seba.js`) into the directory where the `build.sh` is located (that is, this directory).


## Copyright & license

SeBaWeb is copyright (c) 2026, Universify of Amsterdam. It is licensed under the MIT license; see the LICENSE file.
