class Video < ActiveRecord::Base
  belongs_to :profile

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  before_create -> do
    uid = link.match(YT_LINK_FORMAT)

    self.uid = uid[2] if uid && uid[2]

    if self.uid.to_s.length != 11
      self.errors.add(:link, 'is invalid.')
      false
    elsif Video.where(uid: self.uid).any?
      self.errors.add(:link, 'is not unique.')
      false
    else
      get_additional_info
    end
  end

  validates :link, presence: true, format: YT_LINK_FORMAT

  private

  def get_additional_info
    begin
      client = YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyCBYVBzgVuKojWHyv19mi-kalpWQrtLeik')
      video = client.video_by(uid)
      self.title = video.title
      
  video.uid = uid
    rescue
      self.title = '' ;
    end
  end

end