Quick prototyping platform for your HTML/CSS needs
==================================================

To use, just clone this repository and type::

./fiddle.sh

The script creates a new fiddling directory, starts up MVIM and the WSGI-server with Bottle Framework. Use ``<Leader>r`` to compile and open the file in browser or refresh it. Set ``g:fiddle_browser`` to the default browser you are having or leave it as is to
use Google Chrome.

Check out ``fiddle.sh`` for configuration options such as VIM executable name and the directory where to put the fiddles
in. **Note:** if you use Rooter or a plugin that changes the current working directory, this script might not work.

Screenshot
==========

.. image:: http://play.taiste.fi/stuf/vim-fiddle.png

Requirements
============

* Python
* HAML_
* SASS_

.. _HAML: http://haml-lang.com/
.. _SASS: http://sass-lang.com/

Licence 
------- 
 
Licenced under MIT:: 
 
    Copyright (C) 2011 by Mikko Harju 
 
    Permission is hereby granted, free of charge, to any person obtaining a copy 
    of this software and associated documentation files (the "Software"), to deal 
    in the Software without restriction, including without limitation the rights 
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
    copies of the Software, and to permit persons to whom the Software is 
    furnished to do so, subject to the following conditions: 
 
    The above copyright notice and this permission notice shall be included in 
    all copies or substantial portions of the Software. 
 
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
    THE SOFTWARE. 

