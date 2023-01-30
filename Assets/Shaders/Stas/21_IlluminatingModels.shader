Shader "Arikaton/IlluminationModels"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
            float3 viewDir;
        };

        fixed4 _Color;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = IN.worldRefl;
            o.Alpha = c.a;
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}
