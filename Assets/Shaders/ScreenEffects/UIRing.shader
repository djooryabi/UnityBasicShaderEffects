Shader "Custom/ScreenEffects/UIRing"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _XPosition ("X position", float) = 0
        _YPosition ("Y position", float) = 0
        _Radius ("Radius", float) = 0
        _RingThickness ("Ring thickness", float) = 0
    }

    SubShader
    {
        Tags 
        { 
            "RenderType"="Opaque" 
            "IgnoreProjector"="True"
        }

        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _XPosition;
            fixed _YPosition;
            fixed _Radius;
            fixed _RingThickness;
            uniform fixed4 _Color;
            uniform fixed _XScale;
            uniform fixed _YScale;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed dist = distance(fixed2(i.uv.x * _XScale, i.uv.y * _YScale), fixed2(_XPosition * _XScale, _YPosition * _YScale));
                
                if(dist > _Radius && dist < (_Radius + _RingThickness)) {
                    col = _Color;
                }

                return col;
            }
            ENDCG
        }
    }
}
