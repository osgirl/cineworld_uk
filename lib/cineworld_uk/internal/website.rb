# encoding: UTF-8
module CineworldUk
  # Internal utility classes: Do not use
  # @api private
  module Internal
    # fetches pages from the cineworld.co.uk website
    class Website
      def cinema_information(id)
        get("cinemas/#{id}/information")
      end

      def cinemas
        get('cinemas')
      end

      def whatson(id)
        get("whatson?cinema=#{id}")
      end

      private

      def get(path)
        Net::HTTP.get(URI("http://www.cineworld.co.uk/#{path}"))
      end
    end
  end
end
