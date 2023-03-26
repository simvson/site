module Jekyll
  module ImgPathFilter
    def img_path(input)
      config = @context.registers[:site].config
      rele_path = config['img_path'] || ''
      img_name = input.strip
      "#{rele_path}/#{img_name}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::ImgPathFilter)
