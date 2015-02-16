namespace :filter_decrufter do
  
  desc "Find the cruft"
  task :check => :environment do
    FilterDecrufter::Checker.new.check
  end

end