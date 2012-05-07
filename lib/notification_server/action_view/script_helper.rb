module NotificationServer
  module ActionView
    module ScriptHelper

      #
      # Generate script tag for including notification server script
      def javascript_include_notification_server
        html = if defined?(content_tag)
          content_tag 'script', '',
                      src: NotificationServer::Configuration.script_path,
                      type: 'text/javascript'
        else
          "<script type='text/javascript' " +
              " src=\"#{NotificationServer::Configuration.script_path}\">" +
              "</script>"
        end

        _safe html
      end

      #
      # Generate async javascript embeddable code
      #
      # If you use this method remember you can't get "now" variable immediately
      # you have to wait for "now" variable.
      def javascript_include_async_notification_server
        html = <<HTML
<script type='text/javascript' id='__notification_server'></script>
<script type="text/javascript">
(function() {
  if (typeof(jQuery) != 'undefined') {
    setTimeout(function() {
      jQuery('head').append(jQuery('<script />', {
        type: "text/javascript",
        src: "#{NotificationServer::Configuration.script_path}"
      }));
    } , 1000);
  } else {
    document.getElementById('__notification_server').src = "#{NotificationServer::Configuration.script_path}";
  }
})();
</script>
HTML
        _safe html
      end

      private
        def _safe html
          if html.respond_to? :html_safe
            html.html_safe
          else
            html
          end
        end
    end
    
  end
end