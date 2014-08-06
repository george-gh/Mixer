class Channel

  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :name, :protocol, :ip, :port, :url, :type

  validates :protocol, inclusion: { in: %w(http rtsp rtmp hls), message: "%(value) is not a valid protocol" }
  validates :port, format: { with: /\d{2,4}/, message: "Port must be an integer composed by 2-4 digits" }
  validates :ip, format: { with: /\A\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\z/, message: "Invalid IP" }
  validates :type, inclusion: { in: %w(video image audio flash), message: "%(value) is not a supported type" }
  validates :url, presence: true


  def get_stream
    "#{protocol}://#{ip}:#{port}"
  end 

end
