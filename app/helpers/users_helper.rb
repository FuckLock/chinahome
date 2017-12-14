module UsersHelper
  include LetterAvatar::AvatarHelper

  def user_avatar_width_for_size(size)
    case size
    when :xs then 16
    when :sm then 32
    when :md then 48
    when :lg then 96
    else size
    end
  end

  def user_avatar_tag(user, version = :md)
    width = user_avatar_width_for_size(version)
    img_class = "media-object avatar-#{width}"
    if user.avatar?
      raw(image_tag(user.avatar.url, class: img_class))
    else
      raw(image_tag(letter_avatar_url(user.login, width), class: img_class))
    end
  end
end
