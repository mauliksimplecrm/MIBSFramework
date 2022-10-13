/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Florent Vilmart
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"//<SDWebImage/SDWebImageCompat.h>

//! Project version number for SDWebImage.
FOUNDATION_EXPORT double SDWebImageVersionNumber;

//! Project version string for SDWebImage.
FOUNDATION_EXPORT const unsigned char SDWebImageVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <SDWebImage/PublicHeader.h>

#import "SDWebImageManager.h" //<SDWebImage/SDWebImageManager.h>
#import "SDWebImageCacheKeyFilter.h" //<SDWebImage/SDWebImageCacheKeyFilter.h>
#import "SDWebImageCacheSerializer.h" //<SDWebImage/SDWebImageCacheSerializer.h>
#import "SDImageCacheConfig.h" //<SDWebImage/SDImageCacheConfig.h>
#import "SDImageCache.h" //<SDWebImage/SDImageCache.h>
#import "SDMemoryCache.h" //<SDWebImage/SDMemoryCache.h>
#import "SDDiskCache.h" //<SDWebImage/SDDiskCache.h>
#import "SDImageCacheDefine.h" //<SDWebImage/SDImageCacheDefine.h>
#import "SDImageCachesManager.h" //<SDWebImage/SDImageCachesManager.h>
#import "UIView+WebCache.h" //<SDWebImage/UIView+WebCache.h>
#import "UIImageView+WebCache.h" //<SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+HighlightedWebCache.h" //<SDWebImage/UIImageView+HighlightedWebCache.h>
#import "SDWebImageDownloaderConfig.h" //<SDWebImage/SDWebImageDownloaderConfig.h>
#import "SDWebImageDownloaderOperation.h" //<SDWebImage/SDWebImageDownloaderOperation.h>
#import "SDWebImageDownloaderRequestModifier.h" //<SDWebImage/SDWebImageDownloaderRequestModifier.h>
#import "SDWebImageDownloaderResponseModifier.h" //<SDWebImage/SDWebImageDownloaderResponseModifier.h>
#import "SDWebImageDownloaderDecryptor.h" //<SDWebImage/SDWebImageDownloaderDecryptor.h>
#import "SDImageLoader.h" //<SDWebImage/SDImageLoader.h>
#import "SDImageLoadersManager.h" //<SDWebImage/SDImageLoadersManager.h>
#import "UIButton+WebCache.h" //<SDWebImage/UIButton+WebCache.h>
#import "SDWebImagePrefetcher.h" //<SDWebImage/SDWebImagePrefetcher.h>
#import "UIView+WebCacheOperation.h" //<SDWebImage/UIView+WebCacheOperation.h>
#import "UIImage+Metadata.h" //<SDWebImage/UIImage+Metadata.h>
#import "UIImage+MultiFormat.h" //<SDWebImage/UIImage+MultiFormat.h>
#import "UIImage+MemoryCacheCost.h" //<SDWebImage/UIImage+MemoryCacheCost.h>
#import "UIImage+ExtendedCacheData.h" //<SDWebImage/UIImage+ExtendedCacheData.h>
#import "SDWebImageOperation.h" //<SDWebImage/SDWebImageOperation.h>
#import "SDWebImageDownloader.h" //<SDWebImage/SDWebImageDownloader.h>
#import "SDWebImageTransition.h" //<SDWebImage/SDWebImageTransition.h>
#import "SDWebImageIndicator.h" //<SDWebImage/SDWebImageIndicator.h>
#import "SDImageTransformer.h" //<SDWebImage/SDImageTransformer.h>
#import "UIImage+Transform.h" //<SDWebImage/UIImage+Transform.h>
#import "SDAnimatedImage.h" //<SDWebImage/SDAnimatedImage.h>
#import "SDAnimatedImageView.h" //<SDWebImage/SDAnimatedImageView.h>
#import "SDAnimatedImageView+WebCache.h" //<SDWebImage/SDAnimatedImageView+WebCache.h>
#import "SDAnimatedImagePlayer.h" //<SDWebImage/SDAnimatedImagePlayer.h>
#import "SDImageCodersManager.h" //<SDWebImage/SDImageCodersManager.h>
#import "SDImageCoder.h" //<SDWebImage/SDImageCoder.h>
#import "SDImageAPNGCoder.h" //<SDWebImage/SDImageAPNGCoder.h>
#import "SDImageGIFCoder.h" //<SDWebImage/SDImageGIFCoder.h>
#import "SDImageIOCoder.h" //<SDWebImage/SDImageIOCoder.h>
#import "SDImageFrame.h" //<SDWebImage/SDImageFrame.h>
#import "SDImageCoderHelper.h" //<SDWebImage/SDImageCoderHelper.h>
#import "SDImageGraphics.h" //<SDWebImage/SDImageGraphics.h>
#import "SDGraphicsImageRenderer.h" //<SDWebImage/SDGraphicsImageRenderer.h>
#import "UIImage+GIF.h" //<SDWebImage/UIImage+GIF.h>
#import "UIImage+ForceDecode.h" //<SDWebImage/UIImage+ForceDecode.h>
#import "NSData+ImageContentType.h" //<SDWebImage/NSData+ImageContentType.h>
#import "SDWebImageDefine.h" //<SDWebImage/SDWebImageDefine.h>
#import "SDWebImageError.h" //<SDWebImage/SDWebImageError.h>
#import "SDWebImageOptionsProcessor.h" //<SDWebImage/SDWebImageOptionsProcessor.h>
#import "SDImageIOAnimatedCoder.h" //<SDWebImage/SDImageIOAnimatedCoder.h>
#import "SDImageHEICCoder.h" //<SDWebImage/SDImageHEICCoder.h>
#import "SDImageAWebPCoder.h" //<SDWebImage/SDImageAWebPCoder.h>

// Mac
#if __has_include(<SDWebImage/NSImage+Compatibility.h>)
#import <SDWebImage/NSImage+Compatibility.h>
#endif
#if __has_include(<SDWebImage/NSButton+WebCache.h>)
#import <SDWebImage/NSButton+WebCache.h>
#endif
#if __has_include(<SDWebImage/SDAnimatedImageRep.h>)
#import <SDWebImage/SDAnimatedImageRep.h>
#endif

// MapKit
#if __has_include(<SDWebImage/MKAnnotationView+WebCache.h>)
#import <SDWebImage/MKAnnotationView+WebCache.h>
#endif
