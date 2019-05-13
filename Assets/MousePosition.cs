using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MousePosition : MonoBehaviour
{
    Renderer render;

    // Start is called before the first frame update
    void Start()
    {
        render = GetComponent<Renderer>();

        render.material.shader = Shader.Find("Custom/HillFromTexture");
    }
    float timer = 1.0f;
    // Update is called once per frame
    void Update()
    {
       
        if(Input.GetKey(KeyCode.W))
        {

           if( !(1+(timer*0.01f) > 1.48f))
            {
                render.material.SetFloat("_DisplacementAmt", 1+(timer * 0.01f));

                timer++;
            }


           

        }
        else if (Input.GetKey(KeyCode.S))
        {
            if( !(1+(timer*0.01f) < 0.54))
            {


                render.material.SetFloat("_DisplacementAmt", 1 + (timer * 0.01f));
                timer--;
            }
           
        }




        // render.material.SetFloat("_mY", Input.mousePosition.y);


        //Debug.Log(Input.mousePosition);
    }
}
