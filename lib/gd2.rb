#
# Ruby/GD2 -- Ruby binding for gd 2 graphics library
#
# Copyright © 2005-2006 Robert Leslie
#
# This file is part of Ruby/GD2.
#
# Ruby/GD2 is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 2 of the License, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'dl'
require 'rbconfig'

module GD2
  VERSION = '1.1.1'.freeze

  def self.gd_library_name
    case Config::CONFIG['arch']
    when /darwin/
      'libgd.2.dylib'
    when /mswin32/, /cygwin/
      'bgd.dll'
    else
      'libgd.so.2'
    end
  end

  def self.name_for_symbol(symbol, signature)
    case Config::CONFIG['arch']
    when /mswin32/, /cygwin/
      sum = -4
      signature.each_byte do |char|
        sum += case char
          when ?D
            8
          else     4
        end
      end
      "#{symbol}@#{sum}"
    else
      symbol.to_s
    end
  end

  private_class_method :gd_library_name, :name_for_symbol

  LIB = DL.dlopen(gd_library_name)
  SYM = {
    :gdImageCreate                      => 'PII',
    :gdImageCreateTrueColor             => 'PII',
    :gdImageCreatePaletteFromTrueColor  => 'PPII',
    :gdImageCreateFromJpeg              => 'PP',
    :gdImageCreateFromJpegPtr           => 'PIP',
    :gdImageCreateFromPng               => 'PP',
    :gdImageCreateFromPngPtr            => 'PIP',
    :gdImageCreateFromGif               => 'PP',
    :gdImageCreateFromGifPtr            => 'PIP',
    :gdImageCreateFromWBMP              => 'PP',
    :gdImageCreateFromWBMPPtr           => 'PIP',
    :gdImageCreateFromGd                => 'PP',
    :gdImageCreateFromGdPtr             => 'PIP',
    :gdImageCreateFromGd2               => 'PP',
    :gdImageCreateFromGd2Ptr            => 'PIP',
    :gdImageCreateFromGd2Part           => 'PPIIII',
    :gdImageCreateFromXbm               => 'PP',
    :gdImageCreateFromXpm               => 'PS',
    :gdImageCompare                     => 'IPP',
    :gdImageJpeg                        => '0PPI',
    :gdImageJpegPtr                     => 'PPiI',
    :gdImagePngEx                       => '0PPI',
    :gdImagePngPtrEx                    => 'PPiI',
    :gdImageGif                         => '0PP',
    :gdImageGifPtr                      => 'PPi',
    :gdImageWBMP                        => '0PIP',
    :gdImageWBMPPtr                     => 'PPiI',
    :gdImageGd                          => '0PP',
    :gdImageGdPtr                       => 'PPi',
    :gdImageGd2                         => '0PPII',
    :gdImageGd2Ptr                      => 'PPIIi',
    :gdImageDestroy                     => '0P',
    :gdImageSetPixel                    => '0PIII',
    :gdImageGetPixel                    => 'IPII',
    :gdImageGetTrueColorPixel           => 'IPII',
    :gdImageLine                        => '0PIIIII',
    :gdImageRectangle                   => '0PIIIII',
    :gdImageFilledRectangle             => '0PIIIII',
    :gdImagePolygon                     => '0PPII',
    :gdImageOpenPolygon                 => '0PPII',
    :gdImageFilledPolygon               => '0PPII',
    :gdImageArc                         => '0PIIIIIII',
    :gdImageFilledArc                   => '0PIIIIIIII',
#   :gdImageEllipse                     => '0PIIIII',
    :gdImageFilledEllipse               => '0PIIIII',
    :gdImageFill                        => '0PIII',
    :gdImageFillToBorder                => '0PIIII',
    :gdImageSetClip                     => '0PIIII',
    :gdImageGetClip                     => '0Piiii',
    :gdImageBoundsSafe                  => 'IPII',
    :gdImageSetBrush                    => '0PP',
    :gdImageSetTile                     => '0PP',
    :gdImageSetAntiAliased              => '0PI',
    :gdImageSetAntiAliasedDontBlend     => '0PII',
    :gdImageSetStyle                    => '0PAI',
    :gdImageSetThickness                => '0PI',
    :gdImageInterlace                   => '0PI',
    :gdImageAlphaBlending               => '0PI',
    :gdImageSaveAlpha                   => '0PI',
    :gdImageColorTransparent            => '0PI',
    :gdImageColorResolveAlpha           => 'IPIIII',
    :gdImageColorExactAlpha             => 'IPIIII',
    :gdImageColorClosestAlpha           => 'IPIIII',
    :gdImageColorClosestHWB             => 'IPIII',
    :gdImageColorAllocateAlpha          => 'IPIIII',
    :gdImageColorDeallocate             => '0PI',
    :gdAlphaBlend                       => 'III',
    :gdImageCopy                        => '0PPIIIIII',
    :gdImageCopyResized                 => '0PPIIIIIIII',
    :gdImageCopyResampled               => '0PPIIIIIIII',
    :gdImageCopyRotated                 => '0PPDDIIIII',
    :gdImageCopyMerge                   => '0PPIIIIIII',
    :gdImageCopyMergeGray               => '0PPIIIIIII',
    :gdImageSquareToCircle              => 'PPI',
    :gdImageSharpen                     => '0PI',
    :gdImageChar                        => '0PPIIII',
    :gdImageCharUp                      => '0PPIIII',
    :gdImageString                      => '0PPIISI',
    :gdImageStringUp                    => '0PPIISI',
    :gdImageStringFTEx                  => 'SPaISDDIISP',
    :gdImageStringFTCircle              => 'SPIIDDDSDSSI',
    :gdFontGetSmall                     => 'P',
    :gdFontGetLarge                     => 'P',
    :gdFontGetMediumBold                => 'P',
    :gdFontGetGiant                     => 'P',
    :gdFontGetTiny                      => 'P',
    :gdFontCacheSetup                   => 'I',
    :gdFontCacheShutdown                => '0',
    :gdFTUseFontConfig                  => 'II',
    :gdFree                             => '0P'
  }.inject({}) { |x, (k, v)| x[k] = LIB[name_for_symbol(k, v), v]; x }

  # Bit flags for Image#compare

  CMP_IMAGE         =   1  # Actual image IS different
  CMP_NUM_COLORS    =   2  # Number of Colours in pallette differ
  CMP_COLOR         =   4  # Image colours differ
  CMP_SIZE_X        =   8  # Image width differs
  CMP_SIZE_Y        =  16  # Image heights differ
  CMP_TRANSPARENT   =  32  # Transparent colour
  CMP_BACKGROUND    =  64  # Background colour
  CMP_INTERLACE     = 128  # Interlaced setting
  CMP_TRUECOLOR     = 256  # Truecolor vs palette differs

  # Format flags for Image#gd2

  FMT_RAW           =   1
  FMT_COMPRESSED    =   2

  # Color constants

  MAX_COLORS        = 256

  RGB_MAX           = 255

  ALPHA_MAX         = 127
  ALPHA_OPAQUE      =   0
  ALPHA_TRANSPARENT = 127

  class LibraryError < StandardError; end
end

require 'gd2/image'
require 'gd2/color'
require 'gd2/palette'
require 'gd2/canvas'
require 'gd2/font'

class Numeric
  if not self.instance_methods.include? 'degrees'
    # Express an angle in degrees, e.g. 90.degrees. Angles are converted to
    # radians.
    def degrees
      self * 2 * Math::PI / 360
    end
    alias degree degrees
  end

  if not self.instance_methods.include? 'to_degrees'
    # Convert an angle (in radians) to degrees.
    def to_degrees
      self * 360 / Math::PI / 2
    end
  end

  if not self.instance_methods.include? 'percent'
    # Express a percentage, e.g. 50.percent. Percentages are floating point
    # values, e.g. 0.5.
    def percent
      self / 100.0
    end
  end

  if not self.instance_methods.include? 'to_percent'
    # Convert a number to a percentage value, e.g. 0.5 to 50.0.
    def to_percent
      self * 100
    end
  end
end
