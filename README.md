decorate
========

Example scripts for adding "features" to a running tmux session.

## Usage

    . decorate-internal
    . features/example

## Feature

A feature is a shell script that uses a simple dsl for tmux.

    w srv _srv
    w code _code
    v _watch_css
    h _watch_js

* `w [window-name] [command]` - create a new window
* `v [command]` - vertical split
* `h [command]` - horizontal split

## Pane Creation

The currently attached session is used for creating windows and panes.
Splits act on the last created window. Commands are sent to the last 
created pane.

## Managing Large Commands

Use sourced shell functions for longer commands and place them in files 
named after the feature. Place them in a functions directory and source 
them in your `.bashrc`. For example, this shellscript called `dev-project` 
provides pane commands for a web development project:

    __docker_up() {
      docker inspect --format='{{ .State.Running }}' gt 2> /dev/null
    }

    _srv() {
      cd ~/_dev/project && . docker-kit.sh && dstart
    }

    _code() {
      cd ~/_dev/project
    }

    _watch_css() {
      if [ "$(__docker_up)" == "true" ]; then
        cd ~/_dev/project && docker exec project npm run watch
      else
        _watch_css
      end
    }

    _watch_js() {
      if [ "$(__docker_up)" == "true" ]; then
        cd ~/_dev/project && docker exec project npm run watch-webpack
      else
        _watch_js
      end
    }
