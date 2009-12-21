module ReadyForI18N
  class I18nGenerator
    EXTRACTORS = [LabelExtractor,TextExtractor]
    def self.excute(opt)
      @src_path = opt['source']
      @target_path = opt['destination']
      if @target_path && (!@target_path.end_with? File::SEPARATOR)
        @target_path = "#{@target_path}#{File::SEPARATOR}"  
      end
      @locale = opt['locale']
      @ext = opt['extension'] || '.html.erb'
      dict = ReadyForI18N::LocaleDictionary.new(@locale)
      Dir.glob(File.join(@src_path,"**#{File::SEPARATOR}*#{@ext}")).each do |f|
        result = EXTRACTORS.inject(File.read(f)) do |buffer,extractor|
          extractor.new.extract(buffer){|k,v| dict[k] = v}
        end
        write_target_file(f,result) if @target_path
      end
      dict.write_to STDOUT
    end
  private
    def self.write_target_file(source_file_name,content)
      full_target_path = File.dirname(source_file_name).gsub(@src_path,@target_path)
      FileUtils.makedirs full_target_path
      target_file = File.join(full_target_path,File.basename(source_file_name))
      File.open(target_file,'w+'){|f| f << content}
    end
  end
end