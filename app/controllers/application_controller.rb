class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  # 保存すべきリクエストかどうかを判定
  def storable_location?
    request.get? && !devise_controller? && request.fullpath.exclude?("/customers")
  end

  # ログイン後に戻るべきURLを保存
  def store_user_location!
    store_location_for(:customer, request.fullpath)
  end
end
