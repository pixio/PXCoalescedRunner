Pod::Spec.new do |s|
  s.name             = "PXCoalescedRunner"
  s.version          = "0.1.1"
  s.summary          = "A utility class to coalesce close-together method calls into a single method call."
  s.description      = <<-DESC
                       PXCoalescedRunner lets you coalesce multiple close-together calls to the same method into a single call,
                       which is made once the method has not been called for a specific amount of time.
                       DESC

  s.homepage         = "https://github.com/pixio/PXCoalescedRunner"
  s.license          = 'MIT'
  s.author           = { "Spencer Phippen" => "spencer.phippen@gmail.com" }
  s.source           = { :git => "https://github.com/pixio/PXCoalescedRunner.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/PXCoalescedRunner.{h,m}'
  s.public_header_files = 'Pod/Classes/PXCoalescedRunner.h'
  s.resource_bundles = {
    'PXCoalescedRunner' => ['Pod/Assets/*.png']
  }
end
