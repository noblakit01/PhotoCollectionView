#
#  Be sure to run `pod spec lint PhotoCollection.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PhotoCollectionView"
  s.version      = "1.4.2"
  s.summary      = "Custom CollectionView like as Facebook Feed for iOS."
  s.description  = <<-DESC
                  Simple and highly customizable iOS list image for feed, in Swift. Like Facebook feed.
                  DESC

  s.homepage     = "https://github.com/noblakit01/PhotoCollectionView"

  s.license      = "MIT"

  s.author             = { "noblakit" => "noblakit01@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, "8.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/noblakit01/PhotoCollectionView.git", :tag => s.version }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "Sources/*.swift"
  s.requires_arc = true
  s.dependency "SwiftyImageCache", "~> 1.1.1"  

end
