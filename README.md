[![Gem Version](https://badge.fury.io/rb/infermedica.svg)](https://badge.fury.io/rb/infermedica)

# infermedica
Ruby interface to the infermedica REST API

## Description

This is a Ruby interface to the Infermedica REST API: https://developer.infermedica.com/docs/api

It is (very) loosely based on the Python library: https://github.com/infermedica/python-api.

## Installation

```gem install infermedica```

## Dependencies

* json. I have tested with 1.8.x
* Ruby 2.x

## Quick Start

You will first need to get an API **Id** and *Key* from the **Infermedica** site 
https://developer.infermedica.com/docs/api

To start using the API, require the infermedica gem and create an **Infermedica::Api** object, 
passing the api_id and api_key to the constructor.

The constructor takes a hash as argument, so you have different options to pass the id and key:

```
require 'infermedica'
api = Infermedica::Api.new(api_id: 'xxxxx', api_key: 'xxxxxxxxxxx')
```

Or put the key and id in a .yaml file, read it, and pass the resulting hash to the constructor

In **config.yaml**
```
:api_id: xxxxx
:api_key: xxxxxxxxxxxxxx
:dev_mode: true
```

In **your script**
```
require 'infermedica'
require 'yaml'

access = YAML.load(File.read('./config.yaml'))
api = Infermedica::Api.new(access)
```

## Examples

The **examples** directory has some examples to get you started. They all assume that you have a **config.yaml**
in the same directory. Just create one with your own **api_id** and **api_key** and you should be able to just invoke
ruby on each example.

## Legal

The Infermedica REST API is copyrighted by [Infermedica](http://infermedica.com).

The Ruby code itself is released under the [MIT](https://opensource.org/licenses/MIT) license.

