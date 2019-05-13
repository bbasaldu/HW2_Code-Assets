Shader "Custom/xrayZ"
{
     Properties 
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Outline("Outline", Float) = 0.2
        _Color("Color", Color) = (0,0,0,0)
        _SilColor("Silouette Color", Color) = (0, 0, 0, 1)
        _BaseColor("BaseColor", Color) = (0,0,0,0)
    }

    SubShader 
    {
   
        Pass// outline color
        {
           
        
            Cull Front
            Stencil
            {
                Ref 4
                Comp always
                Pass replace
                ZFail keep
            }
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            float _Outline;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal: NORMAL;
                float2 uv: TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv: TEXCOORD0;
            };

            sampler _MainTex;
            float4 _Color;
            v2f vert(appdata v)
            {
                v2f o;
                v.vertex +=  float4(v.normal, 1.0) * _Outline;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                
                float4 c = tex2D(_MainTex, i.uv);
                float4 col = _Color;
                return col*2;
                //return float4(0,0,0,0);
            }
            
            ENDCG
            
        }
        
        Pass//base color
        {
             
        
          
           
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
         
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv: TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv: TEXCOORD0;
            };

            sampler _MainTex;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }
            float4 _BaseColor;
            fixed4 frag(v2f i) : SV_Target
            {
                
                float4 c = tex2D(_MainTex, i.uv);
                //return c;
               // return float4(0,0,0,0);
               return _BaseColor;
               // float3 col = _Color;
                //return float4(col, 1.0);
            }
            
            ENDCG
            
        }
        ////////
          // xray pass (backfaces)
        Pass //implemented part of the code by https://lindenreid.wordpress.com/2018/03/17/x-ray-shader-tutorial-in-unity/
        {
            Tags //rendered after Geometry and AlphaTest, in back-to-front order
            {
                "Queue" = "Transparent"
            }
            // Won't draw where it sees ref value 4
            Cull Back // draw front faces //
            ZWrite OFF
            ZTest Always
            Stencil
            {
                Ref 3
                Comp Greater
                Fail keep
                Pass replace
            }
            Blend SrcAlpha OneMinusSrcAlpha // blends colors of xray and basic shader
            //Blend SrcColor SrcColor
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            // Properties
            float4 _SilColor;

            struct vertexInput
            {
                float4 vertex : POSITION;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;
                output.pos = UnityObjectToClipPos(input.vertex);
                return output;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                return _SilColor;
            }

            ENDCG
        }

   
        
    }
    
}