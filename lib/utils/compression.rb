module Compression
require 'zip'
require 'zip/filesystem'
  class Zipper
    
    def initialize
      @files = []
      @datas = []
      @dirs = []
      @current_dir = ""
    end
    
    def enter_dir (dirname)
      @current_dir += "#{dirname}/"
      @dirs << @current_dir
    end
    
    def parent_dir
      dirs = @current_dir.split '/'
      dirs.pop
      @current_dir = dirs.join '/'
      if !@current_dir.empty?
        @current_dir += "/"
      end
    end
    
    def add_file (filename, file)
        @files << [@current_dir + filename, file]
    end
    
    def add_data (filename, data)
        @datas << [@current_dir + filename, data]
    end
    
    def finish
      zip_data = nil
      zip_temp_file = Tempfile.new "temp_zip_file"
      begin
        Zip::OutputStream.open(zip_temp_file) {|zos|}
        Zip::File.open(zip_temp_file.path, Zip::File::CREATE) do |zip|
          
          # create directory structure
          @dirs.each do |dir|
            zip.dir.mkdir dir
          end
          
          # add files
          @files.each do |file|
            zip.add(file[0], file[1].path)
          end
          
          # add data
          @datas.each do |data|
            zip.get_output_stream(data[0]) { |f| f.write(data[1])}
          end
          
          # finish
          zip.commit
          zip_data = File.read(zip_temp_file.path)
        end
      ensure
        zip_temp_file.close
        zip_temp_file.unlink
      end
      return zip_data
    end
    
  end
  
end