<h2>[Concise Cg built-in functions](https://www.sjbaker.org/wiki/index.php?title=Concise_Cg_built-in_function_table)
<h2><summary>Shader Cheat Sheet</summary></h2>

<details><summary>Lambert and BlinnPhong</summary>

```
struct SurfaceOutput
{
    fixed3 Albedo;  // diffuse color
    fixed3 Normal;  // tangent space normal, if written
    fixed3 Emission;
    half Specular;  // specular power in 0..1 range
    fixed Gloss;    // specular intensity
    fixed Alpha;    // alpha for transparencies
};
```
</details>

<details><summary>Standard</summary>

```
struct SurfaceOutputStandard
{
    fixed3 Albedo;      // base (diffuse or specular) color
    fixed3 Normal;      // tangent space normal, if written
    half3 Emission;
    half Metallic;      // 0=non-metal, 1=metal
    half Smoothness;    // 0=rough, 1=smooth
    half Occlusion;     // occlusion (default 1)
    fixed Alpha;        // alpha for transparencies
};
```
</details>

<details><summary>Standard Specular</summary>

```
struct SurfaceOutputStandardSpecular
{
    fixed3 Albedo;      // diffuse color
    fixed3 Specular;    // specular color
    fixed3 Normal;      // tangent space normal, if written
    half3 Emission;
    half Smoothness;    // 0=rough, 1=smooth
    half Occlusion;     // occlusion (default 1)
    fixed Alpha;        // alpha for transparencies
};
```
</details>

<details><summary>Vertex/Fragment Structures</summary>
<p><b>AppData</b></p>

```
struct appdata_full {
    float4 vertex : POSITION;       //vertex xyz position
    float4 tangent : TANGENT;
    float3 normal : NORMAL;
    float4 texcoord : TEXCOORD0;    //uv coordinate for first set of UVs
    float4 texcoord1 : TEXCOORD1;   //uv coordinate for second set of UVs
    float4 texcoord2 : TEXCOORD2;   //uv coordinate for third set of UVs
    float4 texcoord3 : TEXCOORD3;   //uv coordinate for fourth set of UVs
    fixed4 color : COLOR;           //per-vertex colour
};
struct v2f
{
    float4 pos :  SV_POSITION;      //The position of the vertex in clipping space.
    float3 normal : NORMAL;         //The normal of the vertex in clipping space.
    float4 uv : TEXCOORD0;          //UV from first UV set.
    float4 textcoord1 : TEXCOORD1;  //UV from second UV set.
    float4 tangent : TANGENT;       //A vector that runs at right angles to a normal.
    float4 diff : COLOR0;           //Diffuse vertex colour.
    float4 spec : COLOR1;           //Specular vertex colour.
}
```
</details>

<details><summary>Multipass Shader Format</summary>

```
Shader "MultipassShader"
{
    Properties    //PROPERTIES BLOCK
    {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
    }

    SubShader    //ENCLOSING SHADER BLOCK
    {                            
        //FIRST PASS - SURFACE SHADER DOES NOT REQUIRE PASS BLOCK
        Tags { "Queue" = "Geometry+1" }
    
        CGPROGRAM
        #pragma surface surf BlinnPhong 
       
        float4 _Color;
        struct Input
        {
        };
       
        void surf (Input IN, inout SurfaceOutput o)
        {
        }
        ENDCG
    
        //SECOND PASS - ANOTHER SURFACE SHADER, NO PASS BLOCK REQUIRED
        ZWrite Off      
        Blend DstColor Zero
        CGPROGRAM
        #pragma surface surf BlinnPhong
        float4 _Color;
        struct Input
        {
        };
     
        void surf (Input IN, inout SurfaceOutput o)
        {
        }
        ENDCG  
    
        //THIRD PASS -  VERT/FRAG NEEDS TO BE ENCLOSED IN PASS
        Pass
        {
            Tags { "LightMode" = "Always" }
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            sampler2D _MainTex;
         
            struct v2f
            {
            };
            
            v2f vert (appdata_full v)
            {
            }
                        
            half4 frag( v2f i ) : COLOR
            {
            }
            ENDCG          
        }
       
        //FOURTH PASS - SIMPLE SHADER LAB FUNCTIONS
        Pass
        {          
            Tags { "LightMode" = "Always" }
            ZWrite Off
            SetTexture [_MainTex]
            {
                 combine constant* texture
            }
        } 
    }
    Fallback "Diffuse
}
```
</details>

<summary><h2>Credits and Extra Resources</h2></summary>

<details><summary>Expand</summary>

Many thanks goes to all the Unity developers out there on the Internet who continue to provide great free resources in the Unity forums and on their own websites.  You can find shader code and extra tutorials that has inspired many of the examples found here at the following locations:

**Relevant Unity Manual References**<p>
https://docs.unity3d.com/Manual/SL-VertexFragmentShaderExamples.html
https://docs.unity3d.com/Manual/SL-SurfaceShaderExamples.html

**Mathematical Formulae for Plasma**<p>
https://www.bidouille.org/prog/plasma

**Original Project Inspiration for Advanced Stencil Lecture**<p>
https://forum.unity.com/threads/unity-4-2-stencils-for-portal-rendering.191890/

**More Freely Available Shader Code Examples**
http://wiki.unity3d.com/index.php/Shader_Code
http://wiki.unity3d.com/index.php?title=Shaders#Unity_5.x_Shaders

**Textures and Normal Maps**<p>
http://www.textures.com

Open Source Shader Plugin For Unity
[LUX](https://www.assetstore.unity3d.com/en/#!/content/16000)
</details>
