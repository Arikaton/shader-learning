Shader "Arikaton/22_BumpedEnvironments" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalText ("Normal Map", 2D) = "normal" {}
		_CubeMap ("Cube Map", CUBE) = "" {}
		_BumpAmount ("Bump Amount", Range(0, 10)) = 1
		_Brightness ("Brightness", Range(0, 10)) = 1
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		half _Brightness;
		half _BumpAmount;
		sampler2D _NormalText;
		samplerCUBE _CubeMap;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Brightness;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_NormalText, IN.uv_MainTex)) * float3(_BumpAmount, _BumpAmount, 1);
			o.Alpha = c.a;
			o.Emission = texCUBE(_CubeMap, WorldReflectionVector(IN, o.Normal)).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}