function toggleSearchBoxDefaultValue() {
  $('#address').focus(function () {
    if (/Full Address/.test(this.value)) {
      this.value = '';
      $(this).addClass('focused');
    }
  }).blur(function () {
    if (this.value == '') {
      this.value = this.defaultValue;
      $(this).removeClass('focused');
    }
  });
}

// What Are You Doing? Box.
jQuery(function() {
  toggleSearchBoxDefaultValue();
});
