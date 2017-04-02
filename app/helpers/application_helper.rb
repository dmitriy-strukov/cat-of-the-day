module ApplicationHelper
  def provider_active_class(provider_name)
    provider_active?(provider_name) ? 'active' : ''
  end

  def provider_active?(provider_name)
    current_user.social_profiles.any? { |profile| profile.service_name == provider_name }
  end

  def tab_active_class(record, collection=SocialProvider.providers_list)
    record_first?(record, collection) ? 'active' : ''
  end

  def record_first?(record, collection)
    record == collection.first
  end

  def profile_owner?(user)
    current_user == user
  end
end
