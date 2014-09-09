Pod::Spec.new do |s|
  s.name         = "ZulaLibrary"
  s.version      = "0.6"
  s.summary      = "Main library of ZulaMobile."

  s.description  = <<-DESC
                    This is the main library for ZulaMobile. See Readme for details
                   DESC

  s.homepage     = "http://www.zulamobile.com"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { "Suleyman Melikoglu" => "suleymanmelikoglu@gmail.com"}
  s.platform     = :ios, '6.0'
  s.source       = { :git => "solomon@melikoglu.info:appcreator_library.git" }
  s.source_files  = 'ZulaLibrary/ZulaLibrary/Classes/**/**/**/**/**/*.{h,m}'
  #s.exclude_files = 'Classes/Exclude'
  #s.resources = "RoboReader/Graphics/*.png"
  s.requires_arc = true
end
