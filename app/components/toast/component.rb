module Toast
    class Component < ViewComponent::Base
        def initialize(type:,  message:)
            @type = type
            @message = message
          end

          def toast_classes
            case @type
            when "notice"
              "bg-blue-100 text-blue-800 border-blue-400"
            when "succes"
              "border-green-400 bg-green-100 text-green-800"
            when "alert"
              "bg-red-100 text-red-800 border-red-400"
            else
              "bg-red-100 text-red-800 border-red-400"
            end
          end

          def toast_btn_classes
            case @type
            when "notice"
              "stroke-blue-800"
            when "succes"
              "stroke-green-800"
            when "alert"
              "stroke-red-800"
            else
              "stroke-red-800"
            end
          end
    end
end
