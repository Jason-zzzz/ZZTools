Pod::Spec.new do |s|

  s.name         = "ZZTools"
  s.version      = "0.0.1"
  s.summary      = "登录模块"

  #s.description  = <<-DESC
  #"登录模块，包括注册，登录，忘记密码"

  s.homepage     = "https://github.com/Jason-zzzz/ZZTools"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

    s.license      = "MIT"

  s.author             = { "Zhaojinsong" => "214171891@qq.com" }

    s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Jason-zzzz/ZZTools.git", :commit => "45afef5256553cfd388464a9f0414868ef53eefb" }

  s.source_files  = "ZZTools/Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

    s.public_header_files = "ZZTools/Classes/**/*.h"

  # s.resource  = "icon.png"
    s.resources = "ZZTools/Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

    s.dependency "HandyFrame"
  # s.dependency "ZZNavigation"

end
