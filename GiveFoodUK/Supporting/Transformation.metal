//
//  Transformation.metal
//  GiveFoodUK
//
//  Created by Nigel Gee on 23/11/2023.
//

#include <metal_stdlib>
using namespace metal;
/// A shader that creates black pixels to be white
///
/// - Parameter position: The user-space coordinate of the current pixel.
/// - Parameter color: The current color of the pixel.
/// - Returns: The new pixel color.
[[ stitchable ]] half4 inverseBlack(float2 position, half4 color) {
    if (color.a > 0) {
        half3 grayValues = half3(0.2125h, 0.7154h, 0.0721h);

        half luma = dot(color.rgb, grayValues);

        half4 white = half4(1, 1, 1, color.a);

        if (luma == 0) {
            return white;
        } else {
            return color;
        }

    } else {
        return color;
    }
}
