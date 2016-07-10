(function ($) {
  $.extend({
    uploadPreview2 : function (options) {

      // Options + Defaults
      var settings = $.extend({
        input_field2: ".image-input",
        preview_box2: ".image-preview",
        label_field2: ".image-label",
        label_default2: "Choose File",
        label_selected2: "Change File",
        no_label2: false
      }, options);

      // Check if FileReader is available
      if (window.File && window.FileList && window.FileReader) {
        if (typeof($(settings.input_field2)) !== 'undefined' && $(settings.input_field2) !== null) {
          $(settings.input_field2).change(function() {
            var files = event.target.files;

            if (files.length > 0) {
              var file = files[0];
              var reader = new FileReader();

              // Load file
              reader.addEventListener("load",function(event) {
                var loadedFile = event.target;

                // Check format
                if (file.type.match('image')) {
                  // Image
                  $(settings.preview_box2).css("background-image", "url("+loadedFile.result+")");
                  $(settings.preview_box2).css("background-size", "cover");
                  $(settings.preview_box2).css("background-position", "center center");
                } else if (file.type.match('audio')) {
                  // Audio
                  $(settings.preview_box2).html("<audio controls><source src='" + loadedFile.result + "' type='" + file.type + "' />Your browser does not support the audio element.</audio>");
                } else {
                  alert("This file type is not supported yet.");
                }
              });

              if (settings.no_label2 == false) {
                // Change label
                $(settings.label_field2).html(settings.label_selected2);
              }

              // Read the file
              reader.readAsDataURL(file);
            } else {
              if (settings.no_label2 == false) {
                // Change label
                $(settings.label_field2).html(settings.label_default2);
              }

              // Clear background
              $(settings.preview_box2).css("background-image", "none");

              // Remove Audio
              $(settings.preview_box2 + " audio").remove();
            }
          });
        }
      } else {
        alert("You need a browser with file reader support, to use this form properly.");
        return false;
      }
    }
  });
})(jQuery);