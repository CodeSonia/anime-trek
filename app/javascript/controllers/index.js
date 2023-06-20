// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutoclickController from "./autoclick_controller"
application.register("autoclick", AutoclickController)

import AutoclickreviewsController from "./autoclickreviews_controller"
application.register("autoclickreviews", AutoclickreviewsController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SearchAnimesController from "./search_animes_controller"
application.register("search-animes", SearchAnimesController)

import PasswordVisibility from 'stimulus-password-visibility'
application.register('password-visibility', PasswordVisibility)

import Reveal from 'stimulus-reveal-controller'
application.register('reveal', Reveal)

import CharacterCounter from 'stimulus-character-counter'
application.register('character-counter', CharacterCounter)

import TextareaAutogrow from 'stimulus-textarea-autogrow'
application.register('textarea-autogrow', TextareaAutogrow)

import ReadMore from 'stimulus-read-more'
application.register('read-more', ReadMore)
