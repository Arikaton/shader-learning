Shader "Denis/BumpedEnvironment"
{
    Properties
    {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {}
        _myBump ("Bump Texture", 2D) = "bump" {}
        _diffuseSlider ("Diffuse Amount", Range(0, 10)) = 1
        _bumpSlider ("Bump Amount", Range(0, 10)) = 1
        _myCube ("Cubemap", CUBE) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _myDiffuse;
            sampler2D _myBump;
            half _bumpSlider;
            half _diffuseSlider;
            samplerCUBE _myCube;

            struct Input{
                float2 uv_myDiffuse;
                float2 uv_myBump;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
                o.Albedo *= float3(_diffuseSlider, _diffuseSlider, _diffuseSlider);
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
                o.Normal *= float3(_bumpSlider, _bumpSlider, _bumpSlider);
                o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
            }

        ENDCG
    }
    FallBack "Diffuse"
}
