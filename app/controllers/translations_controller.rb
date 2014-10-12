module Babbel
  module Controllers
    class TranslationsController < ::ApplicationController

      def create
        if service.translate instance, to: to_language
          success_response
        else
          failure_response
        end
      end

      protected

      def success_response
        head :ok
      end

      def failure_response
        head :unprocessable_entity
      end

      private

      def self.controller_path
        :translations
      end

      def service
        @service ||= Babbel::Services::TranslationService.new
      end

      def instance
        @instance ||= params[:translatable_type].classify.constantize.get_instance params[:translatable_id]
      end

      def to_language
        params[:to] || I18n.locale
      end

    end
  end
end