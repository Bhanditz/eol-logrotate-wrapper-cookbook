eol-logrotate-wrapper Cookbook
======================
Allows creation of logrotate config files according to databag.

Requirements
------------
It should work on any platform with logrotate cookbook installed


Usage
-----
#### eol-logrotate-wrapper::default

Two things have to be done to use this cookbook. 

- Node run list has to inlude eol-logrotate-wrapper recipe:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[eol-logrotate-wrapper]"
  ]
}
```
- logrotates have to be added to eol-logrotate-wrapper/config.json databag:

```json
[
  {
    "name": "chef",
    "nodes": [],
    "path": "/var/log/chef",
  },
  { 
    "name": "eol_app",
    "nodes": ["eol-staging1.core.cli.mbl.edu", "eo.staging2.core.cli.mbl.edu"],
    "path": "/var/www/eol/current/log"
  }
]
```
When "nodes" array is left empty this logrotate works for any machine with 
eol-logrotate-wrapper recipe. Otherwise host will skip all logrotate configurations
which do not contain its node name


Athors
-------------------

[Dmitry Mozzherin][1]

Copyright
---------

Copyright (c) 2014 Marine Biological Laboratory. See LICENSE.txt for
further details.

[1]: https://github.com/dimus

