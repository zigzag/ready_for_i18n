module ReadyForI18N
  class I18nGenerator
    EXTRACTORS = [ErbHelperExtractor,HtmlTextExtractor,HtmlAttrExtractor]
    PATH_PATTERN = /\/views\/(.*)/
    
    def self.excute(opt)
      setupOptions(opt)
      Dir.glob(File.join(@src_path,"**#{File::SEPARATOR}*#{@ext}")).each do |f|
        path = f.match(PATH_PATTERN)[1].gsub(/#{@ext}$/,'').split '/' if opt['dot'] && f =~ PATH_PATTERN
        result = EXTRACTORS.inject(File.read(f)) do |buffer,extractor|
          extractor.new.extract(buffer){|k,v| @dict.push(k,v,path)}
        end
        write_target_file(f,result) if @target_path
      end
      @dict.write_to STDOUT
    end

  private
    def self.setupOptions(opt)
      @src_path = opt['source']
      @locale = opt['locale']
      if opt['nokey']
        @dict = NoKeyDictionary.new(@locale)
      else
        @dict = LocaleDictionary.new(@locale)
        @target_path = opt['destination']
        if @target_path && (!@target_path.end_with? File::SEPARATOR)
          @target_path = "#{@target_path}#{File::SEPARATOR}"  
        end
      end
      @ext = opt['extension'] || '.html.erb'
      ExtractorBase.use_dot(true) if opt['dot']
    end

    def self.write_target_file(source_file_name,content)
      full_target_path = File.dirname(source_file_name).gsub(@src_path,@target_path)
      FileUtils.makedirs full_target_path
      target_file = File.join(full_target_path,File.basename(source_file_name))
      File.open(target_file,'w+'){|f| f << content}
    end
  end
end