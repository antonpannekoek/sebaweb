#! /bin/bash

prettier --tab-width 2 -w index.html
prettier --tab-width 4 -w base.css
prettier --tab-width 4 -w base.js

python -m json.tool --indent 2  nl.json nl-json
python -m json.tool --indent 2  en.json en-json
mv nl-json nl.json
mv en-json en.json
