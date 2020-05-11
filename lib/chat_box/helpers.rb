module ChatBox
  module Helpers
    def chat_section(options={})
      render partial: "chat_box/chat_box"
      # chat_box_right = options[:chat_box_right] || '15px'
      # chat_box_left = options[:chat_box_left] || ''
      # chat_box_top = options[:chat_box_top] || ''
      # chat_box_bottom = options[:chat_box_bottom] || '15px'
      # background_color = options[:background_color] || '#fff'
      # chat_box_width = options[:chat_box_width] || '200px'
      # chat_box_height = options[:chat_box_height] || '350px'
      # text_color = options[:color] || '#000'
      # font_size = options[:font_size] || '20px'
      # content_tag :div,:style=>"max-width:#{chat_box_width};max-height:#{chat_box_height};position: fixed;right: 10px;bottom: 0px;float: right;" do
      #   content_tag :div, '', :style => "background-color:#{background_color};width:100%;height:100%;margin-top:10px;", id:"container" do
      #     content_tag :p, "#{text}", :style => "color:#{text_color};position:relative;font-size:#{font_size};text-align:center;line-height:60px;"
      #   end
      # end
    end
  end
end

class ActionView::Base
  include ChatBox::Helpers
end