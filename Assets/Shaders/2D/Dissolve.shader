Shader "Custom/2D/Dissolve"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PerlinTex ("Perlin texture", 2D) = "white" {}
        _DissolveAmount ("Dissolve amount", Range(0,1)) = 0
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="Transparent" 
            "Queue"="Transparent"
            "IgnoreProjector"="True"
        }

        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
        Cull Back

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
            sampler2D _PerlinTex;
            float4 _MainTex_ST;
            fixed _DissolveAmount;

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
                fixed4 perlinCol = tex2D(_PerlinTex, i.uv);

                if(perlinCol.r < _DissolveAmount) {
                    col.a = 0;
                }

                return col;
            }
            ENDCG
        }
    }
}
