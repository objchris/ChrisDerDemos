Pod::Spec.new do |s|

  s.name         = "EZRecycleImageView"
  s.version      = "0.0.2"
  s.summary      = "using three ImageViews to show images as many as possible"
  s.description  = <<-DESC
		* EZRecycleImageView show Images as many as you want by using of three UIImageView
		* the recycleImageDelegate provide you the way to set the timer and the way to do something after the imageView changing.
                   DESC
  s.homepage     = "https://github.com/Ezfen/EZRecycleImageView"
  s.license      = "MIT"
  s.author       = { "Ezfen" => "ezfen_zhang@163.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/Ezfen/EZRecycleImageView.git", :tag => "0.0.2" }
  s.source_files  = "EZRecycleImageView/RecycleImageView/*.{h,m}"

end
