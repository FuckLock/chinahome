# notifications Config
Notifications.configure do
  # Class name of subject or target model, default: 'User'
  # self.object_class = 'User'

  # Class name of notify_type, default: 'mention'
  # self.notify_type = 'mention'

  # Class name of ancestry model, default: ''
  self.ancestry_type = 'Topic'

  # Class name of second_ancestry model, default: ''
  self.second_ancestry_type = 'Reply'

  # current_user method, default: 'current_user', If is a devise can use default
  # self.second_ancestry_type = 'current_user'

  # Method of user avatar in User model, default: nil
  self.user_avatar_method = 'user_avatar_tag'

end
