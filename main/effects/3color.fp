varying mediump vec2 var_texcoord0; // position of your fragment = output from vertex shader = input for fragment shader

uniform lowp sampler2D texture_sampler;  // your image = texture data used like a reference here to create an image = this is automatically assigned by Defold engine, because you specified an image for a sprite
uniform lowp vec4 color_id;  //vector representing a color in RGBA (red, green, blue, alpha)
// above are uniform variables - passed to the fragment program (first by engine, second by user)

// uniform mediump float array[5]; 
// array = float[5](3.4, 4.2, 5.2, 1.1);

const vec4 palette[] = vec4[](
    vec4(0.0, 0.0, 0.0, 1.0),                         //00
    vec4(60.0/255.0, 61.0/255.0, 97.0/255.0, 1.0),    //01
    vec4(167.0/255.0, 106.0/255.0, 106.0/255.0, 1.0), //02
    vec4(186.0/255.0, 157.0/255.0, 97.0/255.0, 1.0),  //03
    vec4(93.0/255.0, 8.0/255.0, 19.0/255.0, 1.0),     //04
    vec4(219.0/255.0, 92.0/255.0, 145.0/255.0, 1.0),  //05
    vec4(231.0/255.0, 14.0/255.0, 45.0/255.0, 1.0),   //06
    vec4(243.0/255.0, 203.0/255.0, 217.0/255.0, 1.0), //07
    vec4(64.0/255.0, 22.0/255.0, 7.0/255.0, 1.0),     //08
    vec4(247.0/255.0, 141.0/255.0, 31.0/255.0, 1.0),  //09
    vec4(223.0/255.0, 98.0/255.0, 50.0/255.0, 1.0),   //10
    vec4(243.0/255.0, 208.0/255.0, 164.0/255.0, 1.0), //11
    vec4(117.0/255.0, 91.0/255.0, 10.0/255.0, 1.0),   //12
    vec4(251.0/255.0, 241.0/255.0, 113.0/255.0, 1.0), //13
    vec4(250.0/255.0, 202.0/255.0, 42.0/255.0, 1.0),  //14
    vec4(255.0/255.0, 250.0/255.0, 204.0/255.0, 1.0), //15
    vec4(7.0/255.0, 48.0/255.0, 30.0/255.0, 1.0),     //16
    vec4(66.0/255.0, 117.0/255.0, 18.0/255.0, 1.0),   //17
    vec4(125.0/255.0, 175.0/255.0, 49.0/255.0, 1.0),  //18
    vec4(219.0/255.0, 251.0/255.0, 187.0/255.0, 1.0), //19
    vec4(9.0/255.0, 81.0/255.0, 28.0/255.0, 1.0),     //20
    vec4(25.0/255.0, 160.0/255.0, 62.0/255.0, 1.0),   //21
    vec4(86.0/255.0, 227.0/255.0, 185.0/255.0, 1.0),  //22
    vec4(196.0/255.0, 245.0/255.0, 235.0/255.0, 1.0), //23
    vec4(43.0/255.0, 27.0/255.0, 125.0/255.0, 1.0),   //24
    vec4(110.0/255.0, 82.0/255.0, 251.0/255.0, 1.0),  //25
    vec4(75.0/255.0, 151.0/255.0, 243.0/255.0, 1.0),  //26
    vec4(196.0/255.0, 215.0/255.0, 245.0/255.0, 1.0), //27
    vec4(47.0/255.0, 2.0/255.0, 60.0/255.0, 1.0),     //28
    vec4(135.0/255.0, 44.0/255.0, 206.0/255.0, 1.0),  //29
    vec4(220.0/255.0, 101.0/255.0, 247.0/255.0, 1.0), //30
    vec4(145.0/255.0, 135.0/255.0, 195.0/255.0, 1.0)  //31
);


void main()
{
    //write a color of the current fragment to a variable (lowp = low precision (it's enough))
    lowp vec4 color_of_pixel = texture2D(texture_sampler, var_texcoord0.xy);

    if(color_of_pixel.a != 0.) // when alpha value of the color is not 0 (not transparent) (you can get components of this vector like .r, .b, .g and .a)
    {
        if(color_of_pixel.r == 1.)
        {
            color_of_pixel = palette[int(color_id.r)];
        }
        else if(color_of_pixel.r < 1. && color_of_pixel.r > 0.)
        {
            color_of_pixel = palette[int(color_id.g)];
            
        }
        else if(color_of_pixel.r == 0.)
        {
            if(color_id.a == 0.)
            {
                color_of_pixel = palette[int(color_id.b)];
            }
            else
            {
                color_of_pixel = palette[int(color_id.r)];
            }
        }
    }
    gl_FragColor = color_of_pixel;  // write the color_of_pixel to the output gl_FragColor
}