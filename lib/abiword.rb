module OsFunctions

  # universal-darwin9.0 shows up for RUBY_PLATFORM on os X leopard with the bundled ruby.
  # Installing ruby in different manners may give a different result, so beware.
  # Examine the ruby platform yourself. If you see other values please comment
  # in the snippet on dzone and I will add them.

  def is_mac?
    RUBY_PLATFORM.downcase.include?("darwin")
  end

  def is_windows?
     RUBY_PLATFORM.downcase.include?("mswin")
  end

  def is_linux?
     RUBY_PLATFORM.downcase.include?("linux")
  end

  module_function :is_mac? , :is_windows?, :is_linux?
end

module Exceptions
  class AbiwordException  < StandardError; end
end

module Abiword

  class Abiword
    @@binary_path = "abiword"

    def self.doc2pdf(infile)
      convert(infile, 'pdf')
    end

    def self.doc2odt(infile)
      convert(infile, 'odt')
    end

    def self.odt2doc(infile)
      convert(infile, 'doc')
    end

    def self.acceptable_format?(infile)
      mime = MimeMagic.by_magic(File.open(infile)).to_s
      case mime
      when "application/msword" then true
      when "application/vnd.oasis.opendocument.text" then true
      else
        mime
      end
    end

    def self.convert(infile, target_format)
      self.set_binary_path if @@binary_path.empty?
      ext  = File.extname(infile)

      raise Exceptions::AbiwordException, "Input file does not exist" if !File.exists?(infile)

      check_format = acceptable_format?(infile)
      raise Exceptions::AbiwordException, "File type is incorrect : #{check_format}" unless check_format == true

      outfile = File.join(File.dirname(infile),File.basename(infile,".*")) + ".#{target_format}"
      cmd = @@binary_path
      cmd += " --to=#{target_format}"
      cmd += " #{infile}"
      cmd += " -o #{outfile}"

      puts "#{cmd} is Commdna"
      `#{cmd}`

      while !$?.exited?
        sleep 0.01
      end

      exit_status = $?.exitstatus
      raise Exceptions::AbiwordException if exit_status != 0

      return outfile
    end

    def set_binary_path
       @@binary_path = "abiword"
    end
  end
end
