module ApplicationHelper

  def is_active_controller(controller_name, class_name = nil)
      if params[:controller] == controller_name
          class_name == nil ? "active" : class_name
      else
          nil
      end
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end

  # For modal login (start)
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end
  # For modal login (end)
end
