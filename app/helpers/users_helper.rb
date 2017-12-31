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

  def user_avatar_tag(user, version = :md, opts = {})
    width = user_avatar_width_for_size(version)
    img_class = "media-object avatar-#{width}"
    if user.is_a? ActiveRecord::Associations::CollectionProxy
      user_img_array = []
      user.each do |u|
        img = if u.avatar?
                raw(image_tag(u.avatar.url, class: img_class))
              else
                raw(image_tag(letter_avatar_url(u.login, width), class: img_class))
              end
        user_img_array << if opts[:link] == true
                            link_to(raw(img), user_path(u.login))
                          else
                            img
                          end
      end
      raw user_img_array.join(" ")
    else
      img = if user.avatar?
              raw(image_tag(user.avatar.url, class: img_class))
            else
              raw(image_tag(letter_avatar_url(user.login, width), class: img_class))
            end
      return img if opts[:link] != true
      raw(link_to(raw(img), user_path(user.login)))
    end
  end
end
