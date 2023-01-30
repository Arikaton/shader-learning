Shader "Arikaton/23_BumpedEnvironmentChallenge" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NormalText ("Normal Map", 2D) = "normal" {}
		_CubeMap ("Cube Map", CUBE) = "" {}
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _NormalText;
		samplerCUBE _CubeMap;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Normal = UnpackNormalWithScale(tex2D(_NormalText, IN.uv_MainTex), 0.3);
			o.Albedo = float4(texCUBE(_CubeMap, WorldReflectionVector(IN, o.Normal)).rgb, 0.3);
		}
		ENDCG
	}
	FallBack "Diffuse"
}