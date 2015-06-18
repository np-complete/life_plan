desc 'check code with brakeman'
task :brakeman do
  require 'brakeman'
  result = Brakeman.run app_path: '.', print_report: true
  exit Brakeman::Warnings_FoundExit_Code unless result.filtered_warnings.empty?
end
