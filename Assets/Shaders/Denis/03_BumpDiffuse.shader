Shader "Denis/BumpDiffuse"
{
    Properties
    {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _diffuseSlider ("Diffuse Amount", Range(0, 10)) = 1
        _bumpSlider ("Bump Amount", Range(0, 10)) = 1
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myDiffuse;
            sampler2D _myBump;
            half _bumpSlider;
            half _diffuseSlider;

            struct Input{
                float2 uv_myDiffuse;
                float2 uv_myBump;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                o.Albedo *= float3(_diffuseSlider, _diffuseSlider, _diffuseSlider);
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
                o.Normal *= float3(_bumpSlider, _bumpSlider, 1);
            }

        ENDCG
    }
    FallBack "Diffuse"
}
