module ReadyForI18N
  class I18nGenerator
    def self.excute(opt)
      src_path = opt['source']
      target_path = opt['destination']
      target_path = "#{target_path}#{File::SEPARATOR}" unless target_path.end_with? File::SEPARATOR
      locale = opt['locale']
      ext = opt['extension'] || '.html.erb'
      dict = ReadyForI18N::LocaleDictionary.new(locale)
      Dir.glob(File.join(src_path,"**#{File::SEPARATOR}*#{ext}")).each do |f|
        full_target_path = File.dirname(f).gsub(src_path,target_path)
        FileUtils.makedirs full_target_path
        target_file = File.join(full_target_path,File.basename(f))
        ReadyForI18N::LabelExtractor.new(f,target_file).extract{|k,v| dict[k] = v}
        ReadyForI18N::TextExtractor.new(target_file,target_file).extract{|k,v| dict[k] = v}
      end
      dict.write_to STDOUT
    end
  end
end