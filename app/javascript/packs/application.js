// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("chartkick")
require("chart.js")

import 'bootstrap'
import 'jquery'
import 'popper.js'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

function createProgressbar(id, duration, callback) {
  var progressbar = document.getElementById(id);
  progressbar.className = 'progressbar';
  var progressbarinner = document.createElement('div');
  progressbarinner.className = 'inner';

  progressbarinner.style.animationDuration = duration;
  if (typeof(callback) === 'function') {
    progressbarinner.addEventListener('animationend', callback);
  }

  progressbar.appendChild(progressbarinner);
    progressbarinner.style.animationPlayState = 'running';
}

addEventListener('load', function() {
  var countdown_timer = document.getElementById('question_countdown_timer').getAttribute('value');
  createProgressbar('progressbar1', countdown_timer+'s', function() {
  document.getElementById('my-form').submit();
  });
});

addEventListener('load', function() {
  var sternberg_timer = document.getElementById('sternberg_timer').getAttribute('value');
  setInterval(function() {
    if (sternberg_timer > 0) {
      document.getElementById("timer").innerHTML = sternberg_timer;
    }
    sternberg_timer--;
    if (sternberg_timer == 0) {
      $('.question_bank').delay().hide(0);
      document.getElementById("timer").innerHTML = '';
      document.querySelectorAll(".hide_questions").forEach(obj=>obj.classList.remove("hide"));
    }
  }, 1000);
});