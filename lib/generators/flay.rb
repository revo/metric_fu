module MetricFu
  
  class Flay < Generator

    def self.verify_dependencies!
      #`jruby -S flay --help`
      #raise 'sudo gem install flay # if you want the flay tasks' unless $?.success?
    end

    def emit
      metric_dir = MetricFu::Flay.metric_directory
      files_to_flay = MetricFu.flay[:dirs_to_flay].map{|dir| Dir[File.join(dir, "**/*.rb")] }
      system("flay #{files_to_flay.join(" ")} > #{metric_dir}/flay.txt")
      File.open("#{metric_dir}/flay.txt", "r") {|io| @output = io.read}
    end

    def analyze
      @matches = @output.chomp.split("\n\n").map{|m| m.split("\n  ") }
    end

    def to_h
      target = []
      total_score = @matches.shift.first.split('=').last.strip
      @matches.each do |problem|
        reason = problem.shift.strip
        lines_info = problem.map do |full_line|
          name, line = full_line.split(":")
          {:name => name.strip, :line => line.strip}
        end
        target << [:reason => reason, :matches => lines_info]
      end
      {:flay => {:total_score => total_score, :matches => target.flatten}}
    end
  end
end
