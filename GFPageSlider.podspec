Pod::Spec.new do |s|
  s.name         = "GFPageSlider"
  s.version      = "1.1.0"
  s.summary      = "a simple page slider module, easy to use and low coupling"
  s.homepage     = "https://github.com/gydmercy/GFPageSlider"
  s.license      = "MIT"
  s.author       = { "Mercy" => "bluegyd@vip.qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/gydmercy/GFPageSlider.git", :tag => s.version }
  s.source_files  = "GFPageSlider/*.{h,m}"
  s.requires_arc  = true

end