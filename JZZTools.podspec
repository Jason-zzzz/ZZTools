Pod::Spec.new do |s|

  s.name         = "JZZTools"
  s.version      = "0.1.6"
  s.summary      = "登录模块"

  #s.description  = <<-DESC
  #"登录模块，包括注册，登录，忘记密码"

  s.homepage     = "https://github.com/Jason-zzzz/ZZTools"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

    s.license      = "MIT"

  s.author             = { "Zhaojinsong" => "214171891@qq.com" }

    s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Jason-zzzz/ZZTools.git", :tag => s.version.to_s }

  s.source_files  = "ZZTools/Classes/**/*.{h,m,mm}"
  s.exclude_files = "Classes/Exclude"

    s.public_header_files = "ZZTools/Classes/**/*.h"

  # s.resource  = "icon.png"
    s.resources = "ZZTools/Resources/*.{png,xib}"
    s.resource_bundles = { 'ZZNavigationBar' => ['ZZTools/Resources/*.{png,xib}'] }

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.dependency "HandyFrame"
  # s.dependency "ZZNavigation"

end
