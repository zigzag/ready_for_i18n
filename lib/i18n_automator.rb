require 'ready_for_i18n'
require 'fileutils'

module ReadyForI18N
  class I18nAutomator
    def self.run(src_erb_path,target_erb_path,locale_path,locale)
      dict = ReadyForI18N::LocaleDictionary.new(locale)
      Dir.glob(File.join(src_erb_path,'**/*.html.erb')).each do |f|
        target_path = File.dirname(f).gsub(src_erb_path,target_erb_path)
        FileUtils.makedirs target_path
        target_file = File.join(target_path,File.basename(f))
        ReadyForI18N::LabelExtractor.new(f,target_file).extract{|k,v| dict[k] = v}
        ReadyForI18N::TextExtractor.new(target_file,target_file).extract{|k,v| dict[k] = v}
      end
      dict.write_to locale_path
    end
  end
end


srcpath = "/Users/zig/workspace/sonar/tags/1.12/sonar-web/src/main/webapp/WEB-INF/app/views"
ReadyForI18N::I18nAutomator.run(srcpath,'/tmp','/tmp','en')